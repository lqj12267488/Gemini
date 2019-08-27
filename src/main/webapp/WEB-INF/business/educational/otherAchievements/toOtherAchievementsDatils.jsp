<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                            <input name="otherAchievementsId" value="${otherAchievementsId}" type="hidden"/>
                        </header>
                        <div class="form-row">
                            <div class="form-row">
                                <div class="col-md-10" style="overflow: hidden;  margin-bottom: 10px">
                                    <div class="col-md-2 tar">
                                        学生姓名：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <input id="studentName" type="text" class="validate[required,maxSize[100]] form-control"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        学号：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <input id="studentNum" type="text" class="validate[required,maxSize[100]] form-control"/>
                                    </div>
                                    <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                        清空
                                    </button>
                                </div>
                                <div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">


                                </div>
                                <div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">


                                    <div class="col-md-2 tar"></div>
                                    <div class="col-md-2" style="width: 15%;">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <a class="btn btn-default btn-clean" onclick="impdata()">导入</a>
                        <a class="btn btn-default btn-clean" onclick="downTemplate()">下载导入模板</a>
                        <a id="expdata" class="btn btn-default btn-clean" onclick="expdata()">导出</a>
                        <button id="saveBtn" type="button" class="btn btn-default btn-clean" onclick="saveScore()">保存</button>
                        <%--<button type="button" class="btn btn-default btn-clean" onclick="batchDel()">清空</button>--%>
                        <button type="button" class="btn btn-default btn-clean" onclick="batchCommit()">成绩提交</button>
                        <button type="button" class="btn btn-default btn-clean" onclick="batchChangeOpenFlag()">发布成绩</button>
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <form id="scores">
                            <input name="type" value="${type}" type="hidden"/>
                            <table id="listGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="courseId" value="${courseId}" type="hidden"/>
<input id="semesterId" value="${semesterId}" type="hidden"/>
<input id="classId" value="${classId}" type="hidden"/>
<script>
    var listTable;
    var dataS;
    $.post("<%=request.getContextPath()%>/common/getSysDict",{
        name:'QTKSZT',
        where:""
    }, function (data) {
        dataS = data;
    });

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'query_termId');
        });

        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/updateScoreMakeup?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "toEdit"){
                $("#dialog").load("<%=request.getContextPath()%>/scoreChange/editScoreChange?id=" + id);
                $("#dialog").modal("show");
            }
        });

        $("#right").css("overflow","auto");
        $(".sorting_disabled").append("<input type='checkbox' id='checkAll' onclick='check()'>");
    })

    function searchClear() {
        $("#studentName").val("");
        $("#studentNum").val("");

        search();
    }

    function search() {

        $("#checkAll").removeAttr("checked");

        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/otherAchievementsDetails/getOtherAchievementsDatilsList',
                "data": {
                    otherAchievementsId: '${otherAchievementsId}',
                    studentName:$("#studentName").val(),
                    studentNum: $("#studentNum").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"width": "6%",
                    "render": function (data, type, row) { return "<input type='checkbox' text='checkbox' value='" + row.id + "'/>";
                    }
                },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "studentNum","width": "6%","title": "学号"},
                {"data": "studentName","width": "6%","title": "姓名"},
                {"width": "6%","title": "A","data": "scoreA",
                    "render": function (data, type, row) {
                        if(row.commentStates == '1'){return row.scoreA;}
                        var scoreIn = "";
                        if(row.scoreA!=null){scoreIn = row.scoreA;}
                        var html = "<input name='A_"+row.id+"' value='"+scoreIn+"' maxlength='2'>";
                        return html;
                    }
                },
                {"width": "6%","title": "B","data": "scoreB",
                    "render": function (data, type, row) {
                        if(row.commentStates == '1'){return row.scoreB;}
                        var scoreIn = "";
                        if(row.scoreB!=null){scoreIn = row.scoreB;}
                        var html = "<input name='B_"+row.id+"' value='"+scoreIn+"' maxlength='2'>";
                        return html;
                    }
                },
                {"width": "6%","title": "C","data": "scoreC",
                    "render": function (data, type, row) {
                        if(row.commentStates == '1'){return row.scoreC;}
                        var scoreIn = "";
                        if(row.scoreC!=null){scoreIn = row.scoreC;}
                        var html = "<input name='C_"+row.id+"' value='"+scoreIn+"' maxlength='2'>";
                        return html;
                    }
                },
                {"width": "6%","title": "D","data": "scoreD",
                    "render": function (data, type, row) {
                        if(row.commentStates == '1'){return row.scoreD;}
                        var scoreIn = "";
                        if(row.scoreD!=null){scoreIn = row.scoreD;}
                        var html = "<input name='D_"+row.id+"' value='"+scoreIn+"' maxlength='2'>";
                        return html;
                    }
                },
                {"width": "6%","title": "平时合计","data": "peacetimeTotal",
                    "render": function (data, type, row) {
                        if(row.commentStates == '1'){return row.peacetimeTotal;}
                        var scoreIn = "";
                        if(row.peacetimeTotal!=null){scoreIn = row.peacetimeTotal;}
                        var html = "<input name='peacetimeTotal_"+row.id+"' value='"+scoreIn+"' maxlength='3'>";
                        return html;
                    }
                },
                {
                    "width": "6%","title": "总评","data": "generalComment",
                    // "render": function (data, type, row) {
                    //     var dis = "";
                    //     if(row.commentStates == '1'){dis='disabled';}
                    //     var html = "<select name='generalComment_"+row.id+"' "+dis+"  style='min-width: 65px;'>";
                    //     $.each(dataS, function (index, content) {
                    //         if (content.text === row.generalComment) {
                    //             html += "<option value='" + content.id + "' selected='selected'>" + content.text + "</option>";
                    //         } else {
                    //             html += "<option value='" + content.id + "'>" + content.text + "</option>";
                    //         }
                    //     });
                    //     html += "</select>";
                    //     return html;
                    // }
                },
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    //返回
    function back() {
        $("#right").load("<%=request.getContextPath()%>/otherAchievements/otherAchievementsList");
        $("#right").modal("show");
    }

    //导出
    function expdata() {
        var href = "<%=request.getContextPath()%>/otherAchievements/exportOtherAchievements?otherAchievementsId=${otherAchievementsId}";
        $("#expdata").attr("href", href);
    }

    function saveScore() {
        var scores = $("#scores").serializeArray();
        $.post("<%=request.getContextPath()%>/otherAchievementsDetails/saveOtherAchievementsDatilsCon", scores, function (msg) {
            swal({title: msg.msg, type: "success"});
            search();
        })
    }

    function check() {
        if ($("#checkAll").attr("checked")) {
            $("[text='checkbox']").attr("checked", "checked");
        } else {
            $("[text='checkbox']").removeAttr("checked");
        }
    }

    function batchDel() {
        var chk_value = "'";
        if ($('input[text="checkbox"]:checked').length > 0) {
            swal({
                title: "确认清除所选学生的考试成绩?",
                text: "清除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "清除",
                closeOnConfirm: false
            }, function () {
                $('input[text="checkbox"]:checked').each(function () {
                    chk_value += $(this).val() + "','";
                });
                chk_value = chk_value.substring(0, chk_value.length - 2)
                $.get("<%=request.getContextPath()%>/scoreMakeup/delScoreImport?ids=" + chk_value, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    }, function () {
                        listTable.ajax.reload();
                    });
                });
            })
        } else {
            swal({
                title: "请选择一条或多条记录!",
                type: "info"
            });
        }

    }

    function batchCommit() {
        var chk_value = "'";
        if ($('input[text="checkbox"]:checked').length > 0) {
            swal({
                title: "确认提交所选学生的考试成绩?",
                text: "提交后将无法修改，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "提交",
                closeOnConfirm: false
            }, function () {
                $('input[text="checkbox"]:checked').each(function () {
                    chk_value += $(this).val() + "','";
                });
                chk_value = chk_value.substring(0, chk_value.length - 2)
                $.get("<%=request.getContextPath()%>/otherAchievementsDetails/updateCommentStatesByIds?ids=" + chk_value, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    }, function () {
                        listTable.ajax.reload();
                    });
                });
            })
        } else {
            swal({
                title: "请选择一条或多条记录!",
                type: "info"
            });
        }

    }

    function batchChangeOpenFlag() {
        var chk_value = "'";
        if ($('input[text="checkbox"]:checked').length > 0) {
            swal({
                title: "确认发布所选学生的考试成绩?",
                text: "提交后将无法修改，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "发布",
                closeOnConfirm: false
            }, function () {
                $('input[text="checkbox"]:checked').each(function () {
                    chk_value += $(this).val() + "','";
                });
                chk_value = chk_value.substring(0, chk_value.length - 2)
                $.get("<%=request.getContextPath()%>/otherAchievementsDetails/updateOpenFlagsByIds?ids=" + chk_value, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    }, function () {
                        listTable.ajax.reload();
                    });
                });
            })
        } else {
            swal({
                title: "请选择一条或多条记录!",
                type: "info"
            });
        }

    }


    function downTemplate(){
            window.location.href = "<%=request.getContextPath()%>/otherAchievements/toCheckStu?courseId=${courseId}&semesterId=${semesterId}&classId=${classId}";
            return;
    }

    function toCheckedClass(examTypes, scoreType) {
        $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/toCheckedClass?examTypes="+examTypes+"&scoreType="+scoreType+"&scoreExamId=${scoreExamId}");
        $("#dialog").modal("show");
    }

    function changeOpenFlag() {
        swal({
            title: "确认公开成绩?",
            text: "请确定成绩表已完成录入，公开后全校师生皆可查看！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/scoreMakeup/changeOpenFlag", {
                scoreExamId: '${scoreExamId}'
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                search();
            });
        })
    }

    function exportScore(){
        window.location.href = "<%=request.getContextPath()%>/scoreMakeup/exportScoreImport?scoreExamId=${scoreExamId}";
    }
    //导入
    function impdata() {
        $("#dialog").load("<%=request.getContextPath()%>/otherAchievements/otherAchievementsImport?otherAchievementsId=${otherAchievementsId}");
        $("#dialog").modal("show");
    }


</script>