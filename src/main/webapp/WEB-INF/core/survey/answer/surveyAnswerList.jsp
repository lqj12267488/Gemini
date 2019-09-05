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
                "url": '<%=request.getContextPath()%>/survey/answer/getSurveyAnswerList',
            },
            "destroy": true,
            "columns": [
                {"data": "surveyId", "visible": false},
                {"data": "surveyType", "visible": false},
                {"data": "checkFlag", "visible": false},
                {"data":"surveyTitle","title":"主题"},
                {"data":"startTime","title":"开始时间"},
                {"data":"endTime","title":"结束时间"},
                {"data":"surveyTypeShow","title":"调查类型"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        var r = '<span class="icon-eye-open" title="填写" onclick=preview("' + row.surveyId + '")></span>&ensp;&ensp;';
                        return r;
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })


    // 预览
    function preview(id) {
        $("#right").load("<%=request.getContextPath()%>/survey/answer/toAnswer?id=" + id);
    }

    function searchclear() {
        $("#surveyTitleSel").val("");
        search();
    }

    function search() {
        var surveyTitleSel = $("#surveyTitleSel").val();
        surveytable.ajax.url("<%=request.getContextPath()%>/survey/answer/getSurveyAnswerList?surveyTitle="+surveyTitleSel ).load();
    }

</script>