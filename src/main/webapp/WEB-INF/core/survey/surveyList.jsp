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
        surveytable = $("#surveytable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/survey/getSurveyList',
            },
            "destroy": true,
            "columns": [
                {"data": "surveyId", "visible": false},
                {"data":"surveyTitle","title":"问卷主题"},
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
                                '<span class="icon-question-sign" title="编辑提问问题" onclick=editQuestion("' + row.surveyId + '","0")></span>&ensp;&ensp;' +
                                '<span class="icon-list-ul" title="编辑评分选项" onclick=editOption("' + row.surveyId + '","0")></span>&ensp;&ensp;' +
                                '<span class="icon-user" title="添加答题家长" onclick=addPerson("' + row.surveyId + '","0")></span>&ensp;&ensp;' +
                                '<span class="icon-check" title="问卷校验" onclick=checkSurvey("' + row.surveyId + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.surveyId + '")></span>&ensp;&ensp;';
                        }else if(row.checkFlag =='1') {
                            r = '<span class="icon-question-sign" title="查看提问问题" onclick=editQuestion("' + row.surveyId + '","1")></span>&ensp;&ensp;' +
                                '<span class="icon-list-ul" title="查看评分选项" onclick=editOption("' + row.surveyId + '","1")></span>&ensp;&ensp;' +
                                '<span class="icon-user" title="查看答题家长" onclick=addPerson("' + row.surveyId + '","1")></span>&ensp;&ensp;' ;
                        }
                        if( row.checkFlag =='1' && row.startFlag =='0'){
                            r = r + '<span class="icon-star-half-full" title="启动" onclick=changeStart("' + row.surveyId + '")></span>&ensp;&ensp;';
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
    function editQuestion(id,checkFlag) {
        $("#right").load("<%=request.getContextPath()%>/survey/question/toSurveyQuestionList?id=" + id+"&checkFlag="+checkFlag);
    }

    // 编辑选项
    function editOption(id,checkFlag) {
        $("#right").load("<%=request.getContextPath()%>/survey/option/toSurveyOptionList?id=" + id+"&checkFlag="+checkFlag);
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

    function searchclear() {
        $("#surveyTitleSel").val("");
        search();
    }

    function search() {
        var surveyTitleSel = $("#surveyTitleSel").val();
        surveytable.ajax.url("<%=request.getContextPath()%>/survey/getSurveyList?surveyTitle="+surveyTitleSel ).load();
    }

</script>