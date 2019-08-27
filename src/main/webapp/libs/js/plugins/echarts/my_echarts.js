/**
 * Created by Administrator on 2017/8/7.
 */
$(function () {
    var myCharts = new Array(5);//图表个数
    var myChartFlag = new Array(5);
    var options = new Array(5);//图表数组
    var addEchartsLi = '<ul id="eCharts_ul" style="list-style: none;"></ul>';
    var liList = new Array(5);//生成<li>
    var liListAll = '';
    var liListFlag = false;
    var dataArray = null;
    var path = getPath();
    $('#right').append(addEchartsLi);
    if (menuCharsName === '协同办公') {
        $.post(path + '/echartsMenu/getxtbgEcharts', {},
            function (msg) {
                dataArray = msg;
                xtbgCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    } else if (menuCharsName === '教务管理') {
        $.post(path + '/echartsMenu/getTestEcharts', {},
            function (msg) {
                dataArray = msg;
                jwglCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    } else if (menuCharsName === '人事管理') {
        $.post(path + '/echartsMenu/getrsglEcharts', {},
            function (msg) {
                dataArray = msg;
                rsglCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    } else if (menuCharsName === '学生工作') {
        $.post(path + '/echartsMenu/getxsgzEcharts', {},
            function (msg) {
                dataArray = msg;
                xsgzCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    } else if (menuCharsName === '考核评教') {
        $.post(path + '/echartsMenu/getkhglEcharts', {},
            function (msg) {
                dataArray = msg;
                khglCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    } else if (menuCharsName === '总务管理') {
        $.post(path + '/echartsMenu/getzwglEcharts', {},
            function (msg) {
                dataArray = msg;
                zwglCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    }
  /*  else if (menuCharsName === '学生个人空间') {
        xsgrkjCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options);
    } */
    else if (menuCharsName === '党团管理') {
        $.post(path + '/echartsMenu/getdtglEcharts', {},
            function (msg) {
                dataArray = msg;
                //console.log(dataArray);
                dtglCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    } else if (menuCharsName === '舆情管理') {
        yqglCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options);
    } else if (menuCharsName === '教师个人空间') {
        $.post(path + '/echartsMenu/getjsgrkjEcharts', {},
            function (msg) {
                dataArray = msg;
                jsgrkjCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    } else if (menuCharsName === '资源库') {
        $.post(path + '/echartsMenu/getzykEcharts', {},
            function (msg) {
                dataArray = msg;
                zykCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    } else if (menuCharsName === '家长个人空间') {
        jzgrkjCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options);
    } else {
        //console('点击了系统管理或首页');
    }
});







