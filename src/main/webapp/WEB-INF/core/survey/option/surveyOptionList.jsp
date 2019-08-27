<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <span style="font-size: 14px"><div id="head"></div></span>
                    </div>
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" id="addBut"
                                onclick="add()">新增
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="optiontable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="checkFlag" hidden value="${checkFlag}">
    <input id="surveyId" hidden value="${surveyId}">
</div>
<script>
    var optiontable;
    $(document).ready(function () {

        if($("#checkFlag").val()=="1"){
            $("#addBut").css("display","none");
            $("#head").html("查看评分选项");
        }else{
            $("#head").html("编辑评分选项");
        }

        optiontable = $("#optiontable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/survey/option/getSurveyOptionList?surveyId='+$("#surveyId").val(),
            },
            "destroy": true,
            "columns": [
                {"data":"optionId", "visible": false},
                {"data":"surveyId", "visible": false},
                {"data":"optionOrder","title":"选项序号"},
                {"data":"optionValue","title":"选项内容"},
                {"data":"optionCode","title":"选项分值"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        if($("#checkFlag").val()=="1") {
                            return "";
                        }
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.optionId + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.optionId + '")></span>';
                    }
                }
            ],
            'order': [2, 'asc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/survey/option/toSurveyOptionAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/survey/option/toSurveyOptionEdit?id=" + id)
        $("#dialog").modal("show")
    }

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
            $.get("<%=request.getContextPath()%>/survey/option/delSurveyOption?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#optiontable').DataTable().ajax.reload();
                });
            })
        });
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/survey/toSurveyList");
    }

</script>