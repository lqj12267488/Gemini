<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                问卷主题：
                            </div>
                            <div class="col-md-2">
                                <input id="surveyTitleSel"/>
                            </div>
                            <div class="col-md-1 tar">
                                年份：
                            </div>
                            <div class="col-md-2">
                                <select id="f_year"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="surveytable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var surveytable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'f_year');
        });
        surveytable = $("#surveytable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/survey/getSurveyList',
            },
            "destroy": true,
            "columns": [
                {"data": "surveyId", "visible": false},
                {"data": "surveyType", "visible": false},
                {"data": "checkFlag", "visible": false},
                {"data":"yearsShow","title":"年份"},
                {"data":"surveyTitle","title":"主题"},
                {"data":"startTime","title":"开始时间"},
                {"data":"endTime","title":"结束时间"},
                {"data":"surveyTypeShow","title":"调查类型"},
                {"data":"checkFlagShow","title":"是否校验"},
                {"data":"startFlagShow","title":"启动状态"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        var r = '';
                        if(row.checkFlag =='0'){
                            r =  '<span class="icon-edit" title="修改" onclick=edit("' + row.surveyId + '")></span>&ensp;&ensp;' +
                                '<span class="icon-question-sign" title="编辑提问问题" onclick=editQuestion("' + row.surveyId + '","' + row.surveyType + '","0")></span>&ensp;&ensp;' +
                                '<span class="icon-user" title="添加投票答题人" onclick=addStudent("' + row.surveyId + '","0")></span>&ensp;&ensp;' +
                                '<span class="icon-check" title="验证" onclick=checkSurvey("' + row.surveyId + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.surveyId + '")></span>&ensp;&ensp;';
                        }else if(row.checkFlag =='1') {
                            r = '<span class="icon-user" title="查看投票答题人" onclick=addStudent("' + row.surveyId + '","1")></span>&ensp;&ensp;' +
                                '<span class="icon-align-justify" title="查看详细结果" onclick=viewResult("' + row.surveyId + '")></span>&ensp;&ensp;' +
                                '<span class="icon-wrench" title="查看统计结果" onclick=orderResult("' + row.surveyId + '")></span>&ensp;&ensp;' ;
                        }
                        if( row.checkFlag =='1' && (row.startFlag =='0' || row.startFlag =='2')){
                            r = r + '<span class="icon-play" title="启动" onclick=changeStart("' + row.surveyId + '")></span>&ensp;&ensp;';
                        }
                        else if( row.checkFlag =='1' && row.startFlag =='1'){
                            r = r + '<span class="icon-pause" title="停止" onclick=changeEnd("' + row.surveyId + '")></span>&ensp;&ensp;' ;
                        }

                        r = r+'<span class="icon-eye-open" title="预览" onclick=preview("' + row.surveyId + '")></span>&ensp;&ensp;';
                        return r;
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    // 新增问卷
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/survey/toSurveyAdd");
        $("#dialog").modal("show");
    }

    // 修改问卷
    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/survey/toSurveyEdit?id=" + id);
        $("#dialog").modal("show");
    }

    // 编辑问题
    function editQuestion(id,surveyType,checkFlag) {
        $("#right").load("<%=request.getContextPath()%>/survey/question/toSurveyQuestionList"+
            "?id=" + id+"&checkFlag="+checkFlag+"&surveyType="+surveyType);
    }

    // 编辑选项
    function editOption(id,checkFlag) {
        $("#right").load("<%=request.getContextPath()%>/survey/option/toSurveyOptionList?id=" + id+"&checkFlag="+checkFlag);
    }
    function addStudent(id,checkFlag) {
        $("#dialog").load("<%=request.getContextPath()%>/survey/person/toSurveyStudent?id=" + id+"&checkFlag="+checkFlag);
        $("#dialog").modal("show");
    }
    // 添加填卷人
    function addTeacher(id,checkFlag) {
        $("#dialog").load("<%=request.getContextPath()%>/survey/person/toSurveyTeacher?id=" + id+"&checkFlag="+checkFlag);
        $("#dialog").modal("show");
    }

    // 添加填卷人
    function addPerson(id,checkFlag) {
        $("#dialog").load("<%=request.getContextPath()%>/survey/person/toSurveyPerson?id=" + id+"&checkFlag="+checkFlag);
        $("#dialog").modal("show");
    }

    // 预览
    function preview(id) {
        $("#right").load("<%=request.getContextPath()%>/survey/toSurveyPreview?id=" + id);
    }

    // 预览
    function viewResult(id) {
        $("#right").load("<%=request.getContextPath()%>/survey/toViewResult?id=" + id);
    }

    function orderResult(id) {
        $("#right").load("<%=request.getContextPath()%>/survey/toOrderResult?id=" + id);
    }

    // 删除
    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/survey/delSurvey?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#surveytable').DataTable().ajax.reload();
                });
            })
        });
    }

    function checkSurvey(id) {
        $.get("<%=request.getContextPath()%>/survey/checkSurvey?surveyId=" + id, function (msg) {
            swal({
                title: msg.msg,
                type: msg.result
            }, function () {
                $('#surveytable').DataTable().ajax.reload();
            });
        })
    }

    function changeStart(id) {
        $.get("<%=request.getContextPath()%>/survey/changeStartFlaf?surveyId=" + id+"&startFlag=1", function (msg) {
            swal({
                title: msg.msg,
                type: msg.result
            }, function () {
                $('#surveytable').DataTable().ajax.reload();
            });
        })
    }

    function changeEnd(id) {
        $.get("<%=request.getContextPath()%>/survey/changeStartFlaf?surveyId=" + id+"&startFlag=2", function (msg) {
            swal({
                title: "操作成功",
                type: msg.result
            }, function () {
                $('#surveytable').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#surveyTitleSel").val("");
        $("#f_year").val("");
        $("#f_year option:selected").val("");
        search();
    }

    function search() {
        var surveyTitleSel = $("#surveyTitleSel").val();
        surveytable.ajax.url("<%=request.getContextPath()%>/survey/getSurveyList?surveyTitle="+surveyTitleSel+"&years="+$("#f_year option:selected").val()).load();
    }

</script>